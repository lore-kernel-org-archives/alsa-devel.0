From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] hda_intel: Add Oaktrail identifiers
Date: Sat, 31 Dec 2011 17:00:01 +0000
Message-ID: <20111231170001.22cdabdd@pyramind.ukuu.org.uk>
References: <20111228151715.2032.87840.stgit@bob.linux.org.uk>
	<s5hzke8n0o6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
	by alsa0.perex.cz (Postfix) with ESMTP id B3F6F2433F
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 17:59:09 +0100 (CET)
In-Reply-To: <s5hzke8n0o6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Thanks, applied.
> 
> Meanwhile, could you double-check whether AZX_DCAPS_POSFIX_LPIB isn't
> needed?  We have enabled this bit for Poulsbo recently for working
> around problems regarding the playback positions.

Is there a good way to test this and I'll run the test and see.

Alan
