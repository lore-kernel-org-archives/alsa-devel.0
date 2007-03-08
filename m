From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: pcm_multi broken in alsa-lib - no duplex mode with
	jackd
Date: Thu, 8 Mar 2007 12:22:46 -0500
Message-ID: <75b66ecd0703080922g3c34190fha833171d5b715189@mail.gmail.com>
References: <45F044D2.1060903@mnet-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45F044D2.1060903@mnet-online.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: simon.lewis@mnet-online.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 3/8/07, Simon Lewis <simon.lewis@mnet-online.de> wrote:
> Many JACK users have successfully used the following patch:
>
> http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch
>
> I have since learned that many studio64 users have been bitten by this bug.
>
> Please, please, please add the above patch to version 1.014 of ALSA libs
> before they are finally released as stable.

+1

*Something* has to be done about this issue ASAP.  I don't think it's
valid to blame JACK because the code worked perfectly until alsa-lib
was changed.

Lee

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
