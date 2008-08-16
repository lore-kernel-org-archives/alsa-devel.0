From: Travis Place <wishie@wishie.net>
Subject: Problem with latest alsa-info.sh patch
Date: Sun, 17 Aug 2008 05:38:59 +1000
Message-ID: <200808170538.59670.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A8AE243B4
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Aug 2008 21:39:04 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id B35865B6C6
	for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2008 20:03:08 +1000 (EST)
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

The latest patch to allow the uploading to alsa-project.org seems to work 
fine, for the most part, unless you want to use the --pastebin option for the 
legacy upload to pastebin.ca . It seems that the uploaded data gets 
truncated. Not sure if this is the script, or the pastebin having problems. 
Ill look into it a bit more when i have time (its 5:30am here, and i need 
sleep).

Just thought id point this out. I realise the 'default' behaviour is to use 
alsa-project.org for uploading, but i feel the other pastebin.ca mode should 
still function(I personally get people to upload there first, and 
then 'submit' card details to alsa-project.org/db/ afterwards.

Thanks,
Travis Place (wishie)
