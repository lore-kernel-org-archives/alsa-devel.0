From: Andreas Mohr <andi@lisas.de>
Subject: Re: [2.6 patch] sound/pci/azt3328.h: no variables for
	enums
Date: Tue, 22 Jul 2008 19:30:40 +0200
Message-ID: <20080722173040.GA14724@rhlx01.hs-esslingen.de>
References: <20080722172128.GY14846@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 41F8A10389A
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 19:30:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080722172128.GY14846@cs181140183.pp.htv.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Jul 22, 2008 at 08:21:28PM +0300, Adrian Bunk wrote:
> AZF_FREQUENCIES and AZF_GAME_CONFIGS were variables, and this doesn't 
> seem to have been intended.

Argh, of course!

Many thanks go to our janitorial head honcho! ;)

Acked-by: Andreas Mohr <andi@lisas.de>
