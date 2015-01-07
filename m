From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm5102: Use put_unaligned_be16
Date: Wed, 7 Jan 2015 16:47:29 +0000
Message-ID: <20150107164729.GS14516@opensource.wolfsonmicro.com>
References: <20141226044457.GA12777@vaishali-Ideapad-Z570>
 <20150107100103.GR14516@opensource.wolfsonmicro.com>
 <CAK-LDbJxb7KBoX1jUXi7_OChJc2NPMT1rRATTK8ci_8gSZvXCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1D95260534
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 17:47:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAK-LDbJxb7KBoX1jUXi7_OChJc2NPMT1rRATTK8ci_8gSZvXCA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 07, 2015 at 08:54:58PM +0530, Vaishali Thakkar wrote:
> On Wed, Jan 7, 2015 at 3:31 PM, Charles Keepax
> <ckeepax@opensource.wolfsonmicro.com> wrote:
> > On Fri, Dec 26, 2014 at 10:14:57AM +0530, Vaishali Thakkar wrote:
> >> This patch introduces the use of function put_unaligned_be16.
> >> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> >> ---
> >
> > Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> >
> > CCing patches@opensource.wolfsonmicro.com would be handy though.
> 
> Ok. Will keep this in mind while sending patches of audio drivers.
> 
> Do I need to send this patch again with CC??

No its fine I have already acked it now.

Thanks,
Charles
