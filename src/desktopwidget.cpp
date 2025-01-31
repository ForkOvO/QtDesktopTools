#include "desktopwidget.h"

#include <QScreen>
#include <QGuiApplication>
#include <QPropertyAnimation>
#include <QQuickWidget>
#include <QQuickItem>
#include <QApplication>
#include <QMenu>
#include <QSystemTrayIcon>
#include <QPushButton>

DesktopWidget::DesktopWidget(QWidget *parent)
    : QWidget{parent}
{
    // 设置窗口属性
    setWindowTitle("桌面小工具 - 十_OvO脱发开发中");
    setWindowIcon(QIcon(":/res/ten_OvO.png")); // 任务栏图标
    setWindowFlags(Qt::FramelessWindowHint | Qt::WindowStaysOnBottomHint); // 无边框 | 窗口置底
    setAttribute(Qt::WA_TranslucentBackground); // 透明

    // 展开按钮
    m_fullButton = new QPushButton(this);
    m_fullButton->setGeometry(0, 0, 50, 50);
    m_fullButton->setIcon(QIcon(":/res/icon.png"));
    m_fullButton->setIconSize(QSize(50, 50));
    m_fullButton->setStyleSheet("QPushButton{border:0px;}");
    connect(m_fullButton, &QPushButton::clicked, this, &DesktopWidget::onFullWindow); // 点击事件

    // 折叠数据
    m_fullRect = QGuiApplication::primaryScreen()->availableGeometry(); // 全屏不包含任务栏
    m_foldRect = QRect(m_fullRect.width() - 50, m_fullRect.height() / 2 - 25, 50, 50); // 右方居中
    m_foldAnimation = new QPropertyAnimation(this, "geometry"); // 折叠动画
    m_foldAnimation->setDuration(300);

    // 创建 QML 主界面
    m_quickWidget = new QQuickWidget(this);
    m_quickWidget->setAttribute(Qt::WA_AlwaysStackOnTop); // 置顶 置顶qml清空不会影响widget
    m_quickWidget->setClearColor(QColor(Qt::transparent)); // 背景清空
    m_quickWidget->setResizeMode(QQuickWidget::SizeRootObjectToView);
    m_quickWidget->setGeometry(m_fullRect);
    m_quickWidget->setSource(QUrl("qrc:/qml/DesktopMainWindow.qml"));

    // QML界面连接信号槽
    QQuickItem* item = m_quickWidget->rootObject();
    connect(item, SIGNAL(foldBtnClicked()), this, SLOT(onFoldWindow())); // 折叠按钮点击

    // 系统托盘初始化
    trayIconInit();
}

void DesktopWidget::trayIconInit()
{
    // 显示
    QAction* showAction = new QAction("显示");
    connect(showAction, &QAction::triggered, this, &DesktopWidget::show);
    // 退出
    QAction* exitAction = new QAction("退出");
    connect(exitAction , &QAction::triggered, this, &QApplication::exit);

    // 初始化菜单并添加项
    QMenu* trayMenu = new QMenu(this);
    trayMenu->addAction(showAction);
    trayMenu->addAction(exitAction );

    //创建一个系统托盘
    m_trayIcon = new QSystemTrayIcon(this);
    m_trayIcon->setIcon(QIcon(":/res/ten_OvO.png"));
    m_trayIcon->setContextMenu(trayMenu);

    // 双击托盘图标显示主窗口
    connect(m_trayIcon, &QSystemTrayIcon::activated, this, [&](QSystemTrayIcon::ActivationReason reason){
        if (reason == QSystemTrayIcon::DoubleClick) this->show();
    });

    m_trayIcon->show();
}

void DesktopWidget::onFoldWindow()
{
    m_isFold = true;
    m_quickWidget->hide();
    m_foldAnimation->setStartValue(this->geometry());
    m_foldAnimation->setEndValue(m_foldRect);
    m_foldAnimation->start();
}

void DesktopWidget::onFullWindow()
{
    m_isFold = false;
    m_quickWidget->show();
    m_foldAnimation->setStartValue(this->geometry());
    m_foldAnimation->setEndValue(m_fullRect);
    m_foldAnimation->start();
}

void DesktopWidget::mousePressEvent(QMouseEvent *event)
{
    if (m_isFold && (event->buttons() & Qt::RightButton)) // 折叠状态右键开始移动
    {
        m_startPos = event->globalPosition().toPoint() - frameGeometry().topLeft();
    }
}

void DesktopWidget::mouseMoveEvent(QMouseEvent *event)
{
    if (m_isFold && (event->buttons() & Qt::RightButton)) // 移动窗口并存储位置
    {
        move(event->globalPosition().toPoint() - m_startPos);
        m_foldRect = geometry();
    }
}
