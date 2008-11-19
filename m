From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ALSA SoC: Add PCM3008 ALSA SoC driver
Date: Wed, 19 Nov 2008 10:45:26 +0000
Message-ID: <20081119104525.GA13250@sirena.org.uk>
References: <1227076652-23370-1-git-send-email-hugo@hugovil.com>
	<1227076652-23370-2-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 88A7324610
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 11:45:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227076652-23370-2-git-send-email-hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 19, 2008 at 01:37:31AM -0500, Hugo Villeneuve wrote:
> The PCM3008 is a 16-bit stereo audio codec. It accepts
> left-justified format for ADC, and right-justified format
> for DAC. Independent power-down modes for ADC and DAC are
> provided, as well as a digital de-emphasis filter (4 modes).

> Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
