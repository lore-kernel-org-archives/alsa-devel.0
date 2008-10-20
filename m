From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Select source support in alsa soc
Date: Mon, 20 Oct 2008 12:54:00 +0530
Message-ID: <ef0d8a250810200024n1f1a4f90i41c7446241fdbb51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DB821037F6
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 09:24:18 +0200 (CEST)
Received: by gxk10 with SMTP id 10so3201729gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2008 00:24:00 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am in a process of making a asoc driver for costum board.
with OMAP3430 and twl4030 combination..

I have a driver now at a palce where i can play back with stereo headset and

record through line in cable.

I need some understanding of how can i give support for selecting output and
input sources.

I have understood the way it is done in ALSA but i feel the sane should not
be used in
ALSA SOC frame work.

I would be thankful if someone can help me solve this issue.


Thanks,
Neyo
