From: Petr Gladkikh <batyi@mail.ru>
Subject: Re: volume PCM plugin
Date: Mon, 17 Jan 2005 17:16:34 +0600
Message-ID: <41EB9E92.5040302@mail.ru>
References: <200501171511.33573.igor@eellc.ru>	<41EB82B0.2050900@mail.ru> <s5hoefoxrn2.wl@alsa2.suse.de>
Reply-To: batyi@mail.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoefoxrn2.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
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
> At Mon, 17 Jan 2005 15:17:36 +0600,

> Handling with pthread looks nice.  The only concern is that I'm not
> 100% sure whether pthread works in every application.
> As in my last reply, the other features can be easiply implemented in
> softvol (the patch was attached there).  The multiple hooks are easy
> to add as well.

Of course I do not suggest to make many such plugins. But I need some 
time to inspect your code (my day work is Windows/C++ :).

Thanks for response.
/Petr



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
