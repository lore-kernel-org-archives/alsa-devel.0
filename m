From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: Some remarks/bugs/question about M-audio Revolution
 (ice1724)
Date: Thu, 08 May 2003 11:30:00 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBA2398.2050405@student.kuleuven.ac.be>
References: <200305072154.27740.zeb@zebulon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Z=E9bulon?= <zeb@zebulon.org.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>Some remarks though :
>
>- the sound sometimes cracks with some DVDs
>
Are you using a stock mandrake kernel? or a lowlatency one?
I've expierienced that DVD's are not played fluently on my box when 
running a stock redhat 2.4.18 kernel, but there is no problem at all 
when using a low-latency patched kernel. More info at 
http://www.linuxdj.com/audio/lad/resourceslatency.php3

>- xine-alsa crashes, I need to use oss driver in xine (probably through 
>snd-pcm-oss), but not directly the alsa drivers. Then no multichannel could 
>be used.
>
I also expierenced that, but only when using multichannel audio. Stereo 
works fine.

Pieter



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
