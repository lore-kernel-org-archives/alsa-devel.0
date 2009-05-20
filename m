From: wirechief <silvermachineman@gmail.com>
Subject: Acer Aspire One codec: Realtek ALC272 not found in
	ALSA-Configuration.txt Mic does not capture in alsamixer
Date: Wed, 20 May 2009 10:03:47 -0400
Message-ID: <fee9dc710905200703g1a8f4371g7e2c9b0f4a4fbe9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 82DC210388F
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 16:03:48 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so253846qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 20 May 2009 07:03:47 -0700 (PDT)
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

Host/Kernel/OS  "wirechief-notebook" running Linux
2.6.30-020630rc5-generic i686 [ Jaunty 9.04 remix ]
CPU Info        (1) Intel Atom N270 @ 512 KB cache flags( sse3 )
clocked at [ 1333.000 MHz ]
                (2) Intel Atom N270 @ 512 KB cache flags( sse3 )
clocked at [ 800.000 MHz ]
Videocard       Intel Mobile 945GME Express Integrated Graphics
Controller  X.Org 1.6.0  [ 1024x600@60.0hz ]
Network cards   Attansic Corp. L1e Gigabit Ethernet Adapter, at port: 1000
                Atheros AR242x 802.11abg Wireless PCI Express Adapter
Processes 154 | Uptime 2:44 | Memory 357.3/993.4MB | HDD Verbatim
STORE N GO,ATA TOSHIBA MK1652GS,Generic- Multi-Card Size 166GB
(1%used) | Client Shell | Infobash v3.11

my alsa info report:
http://www.alsa-project.org/db/?f=83ac843507b5450f5c4d3252a0082ef6f9c6f124

I am not able to see a sound indication with : arecord -f cd -vv /dev/null

-- 
Reach out and share life, care for others,
