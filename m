From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2: Make
	tpa6130a2_power as static
Date: Mon, 12 Oct 2009 13:41:10 +0100
Message-ID: <20091012124110.GA15690@rakim.wolfsonmicro.main>
References: <1255337035-24442-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72CB7103865
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 14:41:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255337035-24442-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, eduardo.valentin@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 12, 2009 at 11:43:55AM +0300, Peter Ujfalusi wrote:
> The power for the amplifier should be handled internally
> by the tpa6130a2 driver.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
