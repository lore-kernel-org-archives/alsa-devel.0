From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Overrun buffer
Date: Fri, 01 Apr 2005 20:47:43 -0500
Message-ID: <1112406463.20579.9.camel@mindpipe>
References: <20050401224309.89334.qmail@web25109.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050401224309.89334.qmail@web25109.mail.ukl.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Laurielle LEA <lauriellelea@yahoo.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-04-02 at 00:43 +0200, Laurielle LEA wrote:
> Hi, 
> 
> I have now a problem of overrun buffer during capture.
> But it's not occured all the time. Sometimes i have
> -EPIPE for snd_pcm_readi
> I tried to use  snd_pcm_prepare(), snd_pcm_drop() or
> snd_pcm_drain() calls but I have still -EPIPE.
> 
> Do you know how can I solve this ?

Please post the problematic code to this mailing list (don't mail it to
me privately).

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
