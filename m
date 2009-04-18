From: Greg Erwin <gerwin@ncsu.edu>
Subject: Getting M-Audio JamLab simple controls to work
Date: Sat, 18 Apr 2009 04:01:04 -0400
Message-ID: <20090418040104.6d7ad3a1@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from uni20mr.unity.ncsu.edu (uni20mr.unity.ncsu.edu [152.1.2.39])
	by alsa0.perex.cz (Postfix) with ESMTP id F004F1037F4
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Apr 2009 10:00:50 +0200 (CEST)
Received: from localhost.localdomain (Sull-03-138.rh.ncsu.edu [152.7.59.138])
	(authenticated bits=0)
	by uni20mr.unity.ncsu.edu (8.13.7/8.13.8/Nv5.2008.0610.1) with ESMTP id
	n3I80kQB006605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2009 04:00:48 -0400 (EDT)
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

I have an M-Audio JamLab usb audio interface.  Long story short, it
works for the most part, but trying to use the simple controls via
amixer or alsamixer don't work.

I've filed a bug report about it a little while back that has quite a
bit of information in it:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4415

Anyway, I feel like it would't take a whole lot to get working (I hope),
but the thing is, I bet very few people actually have one.  I know a
little bit of C, and will be glad to help as much as I can.
