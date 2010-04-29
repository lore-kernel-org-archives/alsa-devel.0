From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv3 1/2] ASoC: TWL4030: AIF/APLL fix in DAPM
	domain
Date: Thu, 29 Apr 2010 10:24:15 +0100
Message-ID: <20100429092415.GC2738@rakim.wolfsonmicro.main>
References: <1272527889-22447-1-git-send-email-peter.ujfalusi@nokia.com>
	<1272527889-22447-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60C4024433
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 11:24:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272527889-22447-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 29, 2010 at 10:58:08AM +0300, Peter Ujfalusi wrote:
> This patch orders the APLL and AIF power sequence in
> case of HiFi (audio in TWL4030 terms) playback/capture.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
