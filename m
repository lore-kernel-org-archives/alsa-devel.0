From: Paul Davis <pbd@op.net>
Subject: Re: hdsp bugfix
Date: Tue, 14 May 2002 09:09:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205141308.PAA25879@alsa.alsa-project.org>
References: <20020514104815.GA17117@localhost>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA25879
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 15:08:39 +0200
In-Reply-To: Your message of "Tue, 14 May 2002 12:48:15 +0200."
             <20020514104815.GA17117@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: martin-langer@gmx.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>there is a small bug in alsa-kernel/pci/Config.help
>The right name for the new hdsp should be "CONFIG_SND_HDSP", or?

Yes, it should. Jaroslav, can you apply this? Sorry I overlooked this
file in my original patch.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
