From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Add VIBRA output
Date: Tue, 5 May 2009 09:48:49 +0100
Message-ID: <20090505084849.GA27386@sirena.org.uk>
References: <1241502947-18151-1-git-send-email-peter.ujfalusi@nokia.com>
	<1241502947-18151-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D8F5A244DA
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 10:48:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1241502947-18151-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 05, 2009 at 08:55:47AM +0300, Peter Ujfalusi wrote:
> This patch adds support for the VIBRA output on TWL4030 codec.
> The VIBRA output can be driven with audio data or with
> local vibrator driver.
> Add the needed DAPM elements and routes for the VIBRA output and
> controls for the VIBRA driver configuration.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
