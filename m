From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][trivial] ASoC: isabelle: Remove unneeded
 include of version.h
Date: Fri, 10 Aug 2012 19:16:31 +0100
Message-ID: <20120810181631.GN24328@opensource.wolfsonmicro.com>
References: <alpine.LNX.2.00.1208102010480.17673@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 189F92665AF
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 19:46:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1208102010480.17673@swampdragon.chaosbits.net>
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

On Fri, Aug 10, 2012 at 08:12:57PM +0200, Jesper Juhl wrote:
> There is no need to include version.h in sound/soc/codecs/isabelle.c -
> this patch removes the pointless include.

Not sure what this patch is against, there appears to be no include of
version.h in current code...
