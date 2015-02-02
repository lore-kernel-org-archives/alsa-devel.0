From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: riptide: off by one in
	snd_riptide_joystick_probe()
Date: Mon, 2 Feb 2015 15:14:50 +0300
Message-ID: <20150202121450.GB7024@mwanda>
References: <20150201204902.GA29129@mwanda>
 <s5hy4ogfvc2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FF93260537
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 13:15:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy4ogfvc2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Hans Wennborg <hans@hanshq.net>, kernel-janitors@vger.kernel.org, Benoit Taine <benoit.taine@lip6.fr>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 02, 2015 at 11:42:37AM +0100, Takashi Iwai wrote:
> 
> So, could you rewrite the patch as a normal off-by-one fix?
> 

Sure, I'll do that later this week.

regards,
dan carpenter
