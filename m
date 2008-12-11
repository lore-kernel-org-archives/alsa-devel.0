From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: ASoC: asound.conf
Date: Thu, 11 Dec 2008 19:25:07 +0530
Message-ID: <ef0d8a250812110555r7d9bf0e5m21318ab4e51848c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f16.google.com (mail-gx0-f16.google.com
	[209.85.217.16]) by alsa0.perex.cz (Postfix) with ESMTP id 00545245DE
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 14:55:08 +0100 (CET)
Received: by gxk9 with SMTP id 9so1133213gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 05:55:07 -0800 (PST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi all,

I have a custom built ASoC CODEC driver for twl4030.
I am integrating my kernel (ASoC driver) with the application.
The application expects a /etc/asound.conf file

is there any utility to build or restore the asound.conf for my
ASoC driver. I have checked the "alsactl" which can give me the
state/controls information.

Do i need to make a asound.conf file.If so, can any one help
my with some information (a sample asound.conf) with details
of the driver in it.

Sorry, if this the wrong place to raise this issue.

-- 
Thanks,
(: Naveen Krishna Ch :)
