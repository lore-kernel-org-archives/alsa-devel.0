From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: Setting invalid samplerate
Date: Thu, 19 May 2011 12:32:55 +0200
Message-ID: <13007d0b220.1968057760595347229.7270538014089164503@zoho.com>
References: <4DD27C43.3050509@canonical.com> <s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com> <s5htycr0zuf.wl%tiwai@suse.de>
	<13007c956d1.7109012681098247941.4235053919533621827@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 5ABCE103818
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 12:32:56 +0200 (CEST)
In-Reply-To: <13007c956d1.7109012681098247941.4235053919533621827@zoho.com>
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

As addition: I used the small tool I found somewhere in the internet to display all samplerates that alsa allows to be set on the card. The result was:

Device: hw:1 (type: HW)
Access types: MMAP_INTERLEAVED RW_INTERLEAVED
Formats: S24_LE S32_LE
Channels: 1 2 3 4 5 6
Sample rates: 64000 88200 192000
Interrupt interval: 1041-256000 us
Buffer size: 2083-512000 us
