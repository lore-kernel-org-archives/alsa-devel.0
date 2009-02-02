From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2.6.30] ASoC: fix build break in
	CS4270	codec driver
Date: Mon, 2 Feb 2009 22:06:46 +0000
Message-ID: <20090202220645.GC29683@sirena.org.uk>
References: <1233607845-7354-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 204F72437B
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 23:06:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233607845-7354-1-git-send-email-timur@freescale.com>
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

On Mon, Feb 02, 2009 at 02:50:45PM -0600, Timur Tabi wrote:
> Fix a oversight in the CS4270 codec driver that caused a build break.

> Signed-off-by: Timur Tabi <timur@freescale.com>

Sorry, I fixed this up locally but with an amend and pushed to Takashi
from the wrong tree.

Applied both, thanks.
