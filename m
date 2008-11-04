From: Travis Place <wishie@wishie.net>
Subject: Current state of HDMI audio with nvidia graphics card ?
Date: Wed, 5 Nov 2008 03:23:10 +1000
Message-ID: <200811050323.10599.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E3AD1037FF
	for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2008 18:23:30 +0100 (CET)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 7B2EEEC0DF
	for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2008 17:50:33 +1000 (EST)
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

Hi all,

So i have 2 machines with nvidia VIDEO cards with HDMI outputs, and HDA-Intel 
sound cards.. i cant get HDMI audio to work on either..

IIRC, we currently need nvidia binary driver 177.80 (or above, if available), 
but what ALSA tree do we need ? sound-unstable ? latest GIT ?

Has anyone heard any reports of nvidia hmdi audio working at all ?

Thanks,
Travis Place (wishie)
