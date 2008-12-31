From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: TWL4030: Make the enum
	filter	generic for twl4030
Date: Wed, 31 Dec 2008 12:26:48 +0000
Message-ID: <20081231122646.GA6596@sirena.org.uk>
References: <1230710918-2741-1-git-send-email-peter.ujfalusi@nokia.com>
	<1230710918-2741-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BC95E1037F9
	for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2008 13:26:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1230710918-2741-2-git-send-email-peter.ujfalusi@nokia.com>
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

On Wed, Dec 31, 2008 at 10:08:37AM +0200, Peter Ujfalusi wrote:
> Modify the enum filter to more generic that it will filter
> out the enums with text "Invalid".
> The enum filter also required for the capture path.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.
