From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: List of control parameters needed
Date: Mon, 22 Mar 2004 15:24:45 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405F053D.2040801@superbug.demon.co.uk>
References: <003701c40fff$1e875800$f8b6a8c0@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <003701c40fff$1e875800$f8b6a8c0@ent.ti.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pavans@india.ti.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pavana Sharma wrote:
> Hello,
> 
> I  am trying to export the controls to user space. I want to know the
> complete list of controls
> which ALSA expects the codec to support. For example, few are as below,
> 
> Master Playback Volume
> Master Playback Switch
> Tone Control - Bass
> Tone Control - Treble
> Line Capture Volume
> Mic Capture Volume
> Mic Sensitivity
> Mic Auto Volume
> Mic Auto Switch
> 
> Where can I get the complete list of controls which an audio codec has to
> support.
> 
> Thanks & Regards
> Pavana S
> 
> 
The envy24/ice1712 cards do not have a Master or PCM control.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
