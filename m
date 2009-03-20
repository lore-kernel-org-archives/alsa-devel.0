From: Halim Sahin <halim.sahin@freenet.de>
Subject: trouble using dmix with tts systems (accessibility )
Date: Fri, 20 Mar 2009 09:28:02 +0000 (UTC)
Message-ID: <20090320092802.GA8779@halim>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A07E2438A
	for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2009 10:30:02 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Lkb3C-0004lR-MX
	for alsa-devel@alsa-project.org; Fri, 20 Mar 2009 09:30:02 +0000
Received: from pd9e3ca8d.dip.t-dialin.net ([217.227.202.141])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2009 09:30:02 +0000
Received: from halim.sahin by pd9e3ca8d.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2009 09:30:02 +0000
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

hello,

I have asked this question to alsa user list but got no useful answer.

I am a blind linux user and need asistive Technology to use my pc.
The problem I have experienced with alsa is that it is sometimes too slow to stop
previous output before starting a new one.
The result of this ends in several speech outputs at a time.
The problem only occurs if the dmix plugin is used.

Is there a way to modify the buffer to avoid these delays???
I have tried to customize my buffer_size vallue in ~/.asoundrc but I wasn't able to
to create a working setup with dmix.


All help appreciated ;-)
Regards
halim
