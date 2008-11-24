From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/9] ASoC: TWL4030: Change the Master
	volume control to TLV
Date: Mon, 24 Nov 2008 13:55:00 +0000
Message-ID: <20081124135459.GD22394@sirena.org.uk>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DA1F41037F8
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:55:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Nov 24, 2008 at 01:49:35PM +0200, Peter Ujfalusi wrote:
> TWL4030 FGAIN volume control has a range:
> -62 to 0 dB in 1 dB steps, 0 in the FGAIN means mute.

Applied.
