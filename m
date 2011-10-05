From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add "Line In" input jack constants
Date: Wed, 5 Oct 2011 16:07:56 +0100
Message-ID: <20111005150753.GB13377@sirena.org.uk>
References: <4E8C6332.2080902@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BFA90243D1
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 17:07:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E8C6332.2080902@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 05, 2011 at 04:01:22PM +0200, David Henningsson wrote:
> Hi,
> 
> Do you think this is reasonable to apply to 3.2? If so I'll continue
> with writing some patches that use this new constant, of course.
> 
> -- 
> David Henningsson, Canonical Ltd.
> http://launchpad.net/~diwic

> From 356e80c4e2f5d9d1c85b5eee93d2932f7637b338 Mon Sep 17 00:00:00 2001
> From: David Henningsson <david.henningsson@canonical.com>
> Date: Wed, 5 Oct 2011 15:53:25 +0200
> Subject: [PATCH] Add "Line In" input jack constants
> 
> Similar to Line Out, these constants form the base for future
> patches enabling input jack reporting for Line in jacks.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but please follow the patch submission process in SubmittingPatches - in
particular, don't send your patch as an attachment.
