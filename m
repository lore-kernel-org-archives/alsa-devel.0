From: onlyfever <onlyfever@gmail.com>
Subject: HELP:How to power down TWL5030 Voice/Bluetooth sidetone PGA?
Date: Thu, 9 Jun 2011 21:40:15 +0800
Message-ID: <BANLkTik0mX5wSYNdBwhjxuaKa6908fmazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I want to power down Voice/Bluetooth sidetone PGA of TWL5030.
I set the VSTPGA Register/BTSTPGA Register to 0x00,but it seems that
the Voice/Bluetooth sidetone PGA still work,
and even set VSTPGA/BTSTPGA to Mute,there still have sidetone come out.

How can I power down Voice/Bluetooth sidetone PGA?
I don't need sidetone.

thanks!
