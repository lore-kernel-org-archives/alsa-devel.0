From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Remove redundant -codec from WM8750
Date: Tue, 9 Aug 2011 13:17:24 +0100
Message-ID: <4E412554.1050804@ti.com>
References: <1312363625-6012-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E2711038DE
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 14:17:27 +0200 (CEST)
In-Reply-To: <1312363625-6012-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/08/11 10:27, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8750.c         |    2 +-
>  sound/soc/pxa/spitz.c             |    2 +-
>  sound/soc/pxa/z2.c                |    2 +-
>  sound/soc/samsung/jive_wm8750.c   |    2 +-
>  sound/soc/samsung/smartq_wm8987.c |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
Acked-by: Liam Girdwood <lrg@ti.com>
