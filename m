From: Francois Gouget <fgouget@codeweavers.com>
Subject: Re: Division by zero in snd_pcm_rate_sw_params()
Date: Sat, 24 Jul 2004 12:36:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41023BB3.5080209@codeweavers.com>
References: <4101BB9E.8010207@codeweavers.com> <410233C3.80602@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <410233C3.80602@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
[...]
> This and other problems are caused by the many bug/problems with the 
> pcm_rate.c plugin. I have been doing some work on the pcm_rate.c plugin, 
> and your patch contains something one of the bug fixes I already have 
> here fixes. I could reproduce it without needing wine.

I just wanted to report the problem to make sure it was known and also 
to check Wine is not doing something wrong.
Since you're obviously aware of the problem and even working on a 
solution everything's perfect!

Thanks for your work.

-- 
Francois Gouget
fgouget@codeweavers.com



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
