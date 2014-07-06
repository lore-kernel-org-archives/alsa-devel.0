From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v5 0/5] ASoC: core: Add support for DAI
	multicodec
Date: Sun, 06 Jul 2014 16:16:39 +0200
Message-ID: <53B95A47.8070108@metafoo.de>
References: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-152.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id E7265264F1D
 for <alsa-devel@alsa-project.org>; Sun,  6 Jul 2014 16:16:44 +0200 (CEST)
In-Reply-To: <1404490075-24997-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/04/2014 06:07 PM, Benoit Cousson wrote:
> Hi Lars, Mark and Liam,
>
> Here is the fifth version of the multicodec series.
>
> It mostly fixes the remaining comments from Lars on the series.
> It removes as well the support for soc-compress.c based on Vinod
> comment.
>
> Please note that I have a very simple setup based on BBB to check if the series
> is working, so it will be good to test it on various platforms to ensure
> this is not generating any regression.
>
> The series is based on asoc/for-next (v3.16-rc3).
>
> Test and comments are welcome.

Whole series:

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Tested-by: Lars-Peter Clausen <lars@metafoo.de>

One tiny issue remaining though.
