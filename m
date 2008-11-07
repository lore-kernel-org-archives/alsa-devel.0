From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] [ALSA] ASoC: TLV320AIC23B Support more
	sample rates
Date: Fri, 7 Nov 2008 14:10:30 +0000
Message-ID: <20081107141029.GC23069@sirena.org.uk>
References: <20081105220550.GA29007@sirena.org.uk>
	<1226013068-22508-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9730124413
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 15:10:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226013068-22508-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, arunks@mistralsolutions.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 06, 2008 at 04:11:08PM -0700, Troy Kisky wrote:
> Add support for more sample rates, different crystals
> and split playback/capture rates.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

> Mark, this is an incremental patch to the #ifdef DEBUG version

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'll squash this down and push it today or Monday.
