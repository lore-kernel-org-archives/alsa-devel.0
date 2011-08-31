From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: Add device tree binding for
	WM8770
Date: Wed, 31 Aug 2011 11:30:32 +0100
Message-ID: <4E5E0D48.5030406@ti.com>
References: <1314624471-15381-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 726CB24498
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 12:30:43 +0200 (CEST)
In-Reply-To: <1314624471-15381-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On 29/08/11 14:27, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/sound/wm8770.txt |   16 ++++++++++++++++
>  sound/soc/codecs/wm8770.c                          |    8 ++++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wm8770.txt
> 

These all look fine to me wrt ASoC. All

Acked-by: Liam Girdwood <lrg@ti.com>
