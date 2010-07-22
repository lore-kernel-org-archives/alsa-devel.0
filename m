From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: multi-component: determine which DAI is active?
Date: Thu, 22 Jul 2010 10:37:27 +0100
Message-ID: <20100722093726.GH10930@sirena.org.uk>
References: <4C4778E5.6090200@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 50D81103970
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 11:37:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4C4778E5.6090200@freescale.com>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 21, 2010 at 05:47:01PM -0500, Timur Tabi wrote:

> In order to get fsl_dma.c to work with the WM8776, which has separate DAIs
> for playback and capture, I've had to do this:

Please CC me on ASoC stuff even if it's multi-component (which hopefully
will be mainline very soon anyway!).  Liam will probably be the one to
answer still but it helps to have visibility.
