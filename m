From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Disable soft-volume
Date: Mon, 24 Nov 2008 13:54:39 +0000
Message-ID: <20081124135438.GC22394@sirena.org.uk>
References: <1227507945-9295-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5298524416
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:54:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227507945-9295-1-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Nov 24, 2008 at 08:25:45AM +0200, Peter Ujfalusi wrote:
> Keep Soft-volume disabled for now, since if it is enabled
> the FGAIN volume controls are not working in the current
> configuration:

Applied.
