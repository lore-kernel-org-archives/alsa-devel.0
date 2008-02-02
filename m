From: Travis Place <wishie@wishie.net>
Subject: alsa-info.sh debugging script
Date: Sat, 2 Feb 2008 23:34:42 +1000
Message-ID: <200802022334.42705.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id D4AF210383B
	for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2008 14:37:10 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id F31134052
	for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2008 13:59:03 +1000 (EST)
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
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I am new to this list, so be nice please :P

I am the author of the alsa-info.sh debugging script, and heard you may want 
to use it within ALSA.. I have been speaking to Tobin, and he mentioned that 
a few things may need to be added (like alsactl output).

I just want to get some ideas of things i can add, and if they should be 
included automatically, or require a --with-alsactl (for example).

I have added the alsactl output to the script now, its included by default.. 
Any other ideas/changes that need to be made ?

Travis Place (wishie)

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
