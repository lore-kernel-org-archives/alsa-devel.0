From: The Source <thesourcehim@gmail.com>
Subject: pulseaudio plugin configuration
Date: Sun, 02 Nov 2008 12:42:28 +0300
Message-ID: <490D7604.8040900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B3A91037EE
	for <alsa-devel@alsa-project.org>; Sun,  2 Nov 2008 10:42:31 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so1178366nfd.32
	for <alsa-devel@alsa-project.org>; Sun, 02 Nov 2008 01:42:30 -0800 (PST)
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

I use alsa-plugins-pulseaudio to make Doom3 use sound (alsa itself is 
used by pulseaudio and snd-sbxfi currently supports only one app at a 
time). But sound is 'delayed'. It plays 2 seconds after it actually 
should play. Should I change some configuration to make it work properly?
