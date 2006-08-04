From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: Re: snd_ctl_open and snd_rawmidi_open conflict
Date: Sat, 5 Aug 2006 01:30:39 +0400
Message-ID: <70a871c80608041430r7b289747ve16936909fa167e4@mail.gmail.com>
References: <70a871c80607301752w16c1c014v40f574d17603f08d@mail.gmail.com>
	<s5h3bchabr4.wl%tiwai@suse.de>
	<70a871c80608011336w52e4d734v533eb650129a5564@mail.gmail.com>
	<s5hmzanhws3.wl%tiwai@suse.de>
	<70a871c80608021254q206ebc31jc8977c4d5e4e0891@mail.gmail.com>
	<s5hodv2gj64.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodv2gj64.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 8/3/06, Takashi Iwai <tiwai@suse.de> wrote:
> The patch below should fix the problems.  Give it a try.

Thanks. It helped.

Dmitry.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
