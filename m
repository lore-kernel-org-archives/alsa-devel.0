From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/9] ASoC: TWL4030: Add CGAIN volume control
Date: Mon, 24 Nov 2008 13:55:25 +0000
Message-ID: <20081124135524.GE22394@sirena.org.uk>
References: <1227527383-22516-1-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-2-git-send-email-peter.ujfalusi@nokia.com>
	<1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 44A1C1037F9
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:55:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227527383-22516-3-git-send-email-peter.ujfalusi@nokia.com>
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

On Mon, Nov 24, 2008 at 01:49:36PM +0200, Peter Ujfalusi wrote:
> Add CGAIN (Coarse gain control) to TWL4030 codec.
> The range of the CGAIN is:
> 0 dB to 12 dB in 6 dB steps.

Applied.
