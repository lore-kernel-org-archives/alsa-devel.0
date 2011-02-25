From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-dapm: Include quotes around
 contents in debugfs entries
Date: Fri, 25 Feb 2011 11:52:24 +0000
Message-ID: <20110225115224.GB28980@opensource.wolfsonmicro.com>
References: <1298567372-7030-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B60C9244A5
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 12:52:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298567372-7030-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 24, 2011 at 05:09:32PM +0000, Dimitris Papastamos wrote:
> Sometimes the name of the control switch of a dapm route contains
> spaces which makes it impossible to distinguish it from the source widget.
> Add quotes around the names of the widgets to makes these parsable.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Applied, thanks.
