From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] SOUND: wm8753, remove dead code
Date: Mon, 6 Sep 2010 11:44:52 +0100
Message-ID: <20100906104452.GF10367@rakim.wolfsonmicro.main>
References: <1283605929-15961-1-git-send-email-jslaby@suse.cz>
	<1283769150.3078.15.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97E6924508
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 12:44:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1283769150.3078.15.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>, jirislaby@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 06, 2010 at 11:32:30AM +0100, Liam Girdwood wrote:
> On Sat, 2010-09-04 at 15:12 +0200, Jiri Slaby wrote:
> > There is adangling code in wm8753_probe which is never executed.
> > Remove it.
> > 
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Jiri, you should know to send copies of patches to maintainers.  Applied
after digging out of a list folder.
