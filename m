From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/3] ALSA: ASoC: McASP: remove unused
	variables
Date: Fri, 7 Dec 2012 14:48:37 +0900
Message-ID: <20121207054835.GG26070@opensource.wolfsonmicro.com>
References: <1354728038-5506-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9635A261742
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 06:48:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1354728038-5506-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: mporter@ti.com, alsa-devel@alsa-project.org, nsekhar@ti.com, vaibhav.bedia@ti.com, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 05, 2012 at 06:20:36PM +0100, Daniel Mack wrote:
> codec_fmt and sample_rate variables are unused in both snd_platform_data
> and davinci_audio_dev, so drop them.

Applied all, thanks.
