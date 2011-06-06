From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/6] ASoC: AD1836: Fix setting the PCM
	format
Date: Mon, 6 Jun 2011 20:39:52 +0100
Message-ID: <4DED2D08.90201@ti.com>
References: <1307360320-4727-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 34BAF243AC
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 21:39:57 +0200 (CEST)
In-Reply-To: <1307360320-4727-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
List-Id: alsa-devel@alsa-project.org

On 06/06/11 12:38, Lars-Peter Clausen wrote:
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> This patch doesn't need to go into stable since there are currently no users of
> PCM formats other than S32, which is the default.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

All

Acked-by: Liam Girdwood <lrg@ti.com>
