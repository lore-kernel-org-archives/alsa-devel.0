From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-dapm: Include quotes around
 contents in debugfs entries
Date: Fri, 25 Feb 2011 09:01:07 +0000
Message-ID: <1298624467.3363.2.camel@odin>
References: <1298567372-7030-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B74B4103813
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 10:01:11 +0100 (CET)
Received: by wwf26 with SMTP id 26so1476800wwf.20
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 01:01:11 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-24 at 17:09 +0000, Dimitris Papastamos wrote:
> Sometimes the name of the control switch of a dapm route contains
> spaces which makes it impossible to distinguish it from the source widget.
> Add quotes around the names of the widgets to makes these parsable.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
