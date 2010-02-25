From: Dale Blount <alsa-lists@dale.us>
Subject: No sound on Dell Optiplex 380
Date: Thu, 25 Feb 2010 10:03:34 -0500
Message-ID: <1267110214.10823.19.camel@dale.velocity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail01.velocity.net (mail01.velocity.net [66.211.211.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 07C002444A
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 16:04:03 +0100 (CET)
Received: from mail01.velocity.net (localhost.localdomain [127.0.0.1])
	by mail01.velocity.net (Postfix) with ESMTP id 9DE1A8CF1B
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 10:02:02 -0500 (EST)
Received: from [66.211.211.211] (dale.velocity.net [66.211.211.211])
	by mail01.velocity.net (Postfix) with ESMTP id 858A08CD10
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 10:02:02 -0500 (EST)
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

Hello,

I've been having issues with this new PC and sound since I got it last
week.  I'm not getting any sound out of the speakers.  I've tried both
rear speaker and front headphone jacks.  It does "pop" when the
snd-hda-intel module is loaded, though. I've tried all the model=X
options listed for my Realtek chipset and made sure that everything is
unmuted and non-zero volume.

My alsa-info.sh report can be found here:

http://www.alsa-project.org/db/?f=fa4aacb98b85d5a02e05df5e9bffa400409b0c21

Please let me know if I can help testing a possible fix or if any other
information is needed.

Thanks,

Dale
