From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: (no subject)
Date: Mon, 18 Dec 2006 10:53:33 +0100
Message-ID: <1166435613.27096.280955357@webmail.messagingengine.com>
References: <JADEDP$7B7661E86B7825A8ECA7FB5E915275AF@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <JADEDP$7B7661E86B7825A8ECA7FB5E915275AF@libero.it>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: tardo2002@libero.it, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

tardo2002@libero.it wrote:
> My problem is: when I am listening to some audio file, sound stream is
> disturbed by a strong noise component. This noise component, in my
> opinion, is strange becouse it follow rhythm of sound stream and there is
> both when PCM volume is 0 (but turned on) even PCM volume is high!

What codec does your motherboard use? (see /proc/asound/cards)
What is the output of "amixer contents"?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
