From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][trivial] ASoC: isabelle: Remove unneeded
 include of version.h
Date: Fri, 10 Aug 2012 19:24:05 +0100
Message-ID: <20120810182405.GO24328@opensource.wolfsonmicro.com>
References: <alpine.LNX.2.00.1208102010480.17673@swampdragon.chaosbits.net>
 <20120810181631.GN24328@opensource.wolfsonmicro.com>
 <alpine.LNX.2.00.1208102019510.17673@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00CDD2665C6
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 19:54:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1208102019510.17673@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: alsa-devel@alsa-project.org, trivial@kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 10, 2012 at 08:21:51PM +0200, Jesper Juhl wrote:
> On Fri, 10 Aug 2012, Mark Brown wrote:

> > Not sure what this patch is against, there appears to be no include of
> > version.h in current code...

> It's against Linus's tree. I created a branch off of master at 
> f4ba394c1b02e7fc2179fda8d3941a5b3b65efb6 and did the patch.

Ah, the fix is only in -next.
