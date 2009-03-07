From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2.6.30] ASoC: Improve
	pause/unpause	performance in Freescale 8610 drivers
Date: Sat, 7 Mar 2009 11:03:59 +0000
Message-ID: <20090307110357.GA18570@sirena.org.uk>
References: <1236386374-17515-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 147421037EC
	for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2009 12:04:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236386374-17515-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 06, 2009 at 06:39:34PM -0600, Timur Tabi wrote:
> Add support for true pause and unpause.  Without this, mplayer will drop some
> audio (less than one second, but still noticeable) when pausing playback.

Applied, thanks!
