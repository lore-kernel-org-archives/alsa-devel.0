From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Support MCP89 hdmi audio
Date: Fri, 30 Jul 2010 20:11:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007302009250.4068@eeebox2.perex-int.cz>
References: <6B4D417B830BC44B8026029FD256F7F1C29D065C70@HKMAIL01.nvidia.com>
	<s5hr5ix2dzb.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C29D065C72@HKMAIL01.nvidia.com>
	<6B4D417B830BC44B8026029FD256F7F1C29D065C7E@HKMAIL01.nvidia.com>
	<s5h39v4vskw.wl%tiwai@suse.de>
	<6B4D417B830BC44B8026029FD256F7F1C29D065C86@HKMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF02FD6DF17B@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 8447E243EB
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 20:11:40 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF17B@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>, 'alsa-devel' <alsa-devel@alsa-project.org>, Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 30 Jul 2010, Stephen Warren wrote:

> Takashi,
>
> I also work for NVIDIA and am starting to work on some audio-related issues.
>
> I'd like to get familiar with the flow of patches; where things get applied
> first and how they flow to public ALSA and kernel repositories, so:
>
> I see the patch below has shown up in the snapshots at:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/
>
> What repository is that a snapshot of; a private repository of yours?
>
> However, I can't find the patch anywhere at:
>
> http://git.alsa-project.org/

It's here now, too. It depends how often I sync my tree with Takashi.

> I'm mainly asking, because I want to work with distro kernel maintainers 
> to get this patch into distros, rather than waiting for new distro 
> versions to ship, which even then might not pick up a kernel with this 
> patch the first time around. However, before I do that, I need to find a 
> sane public upstream location that shows the patch is acceptable 
> upstream.

Post your patches here, to the alsa-devel mailing list. We usually send 
you a reply that we applied your patch to our trees.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
