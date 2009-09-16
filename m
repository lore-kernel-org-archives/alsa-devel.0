From: errordeveloper@gmail.com
Subject: Ethernet AVB - XMOS reference desing
Date: Wed, 16 Sep 2009 15:12:14 +0100
Message-ID: <20090916141214.GA16750@00110101.errordevlopment.0>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BD7C103814
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 15:38:11 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e12so1020778fga.2
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2009 06:38:10 -0700 (PDT)
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

Hello.

I m just getting my head around the whole lot of ethernet audio
protocols avaliable, it's a big deal of brands really ..

but now it looks like there will be a new rather standard protocol -
ieee802.1 ethernet AV bridge.

here is a reference design which includes driver source-code.
i haven't quite figured is tha tlicene is comptible with gpl really..
but i suppose you don't need to use that code, just look at it as a
piece of documentation ..

it could be so great to have ethernet audio in linux!

i have seen the audio science interface and draver exists, but they are
using cobra-net ..which is probably good, but it's not as
standard as ieee AVB.

here you can find an article about the current status of the protocol
mess:
http://prosoundnewseurope.com/pdf/PSNLive/PSNLive_2009.pdf (page 28)

best regards,
-- 
ilya .d 
