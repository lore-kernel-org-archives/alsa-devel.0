From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: Re: [PATCH] more au88x0 eq cleanups
Date: Tue, 21 Sep 2004 17:32:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41509DE2.1050702@rogers.com>
References: <41501995.8030203@rogers.com> <s5hfz5bzu07.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfz5bzu07.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>Could you provide a changelog with a summary and a signed-off-by
>lines?
>
>
>  
>
Sure,

cleanup au88x0 equalizer code by factoring out a sign_invert function 
that ensures all negative integers become positive.

Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
