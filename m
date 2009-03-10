From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/4] ALSA: ASoC: Davinci: Fixed
	missing	McBSP pinmux for SFFSDR
Date: Tue, 10 Mar 2009 15:16:32 +0000
Message-ID: <20090310151615.GB12297@sirena.org.uk>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
	<1236655929-31688-5-git-send-email-hugo@hugovil.com>
	<20090310102921.GA12297@sirena.org.uk>
	<20090310100341.cc08cc08.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4491C1037EB
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 16:16:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090310100341.cc08cc08.hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 10, 2009 at 10:03:41AM -0400, Hugo Villeneuve wrote:

> I based those patches on the latest linux-davinci git tree, which has
> the function.

Do not submit patches for mainline which are not based on mainline
trees.  Code which relies on out of tree changes needs to wait for those
out of tree changes to be merged before submitting to mainline.
