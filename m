From: Dan Hollis <goemon@anime.net>
Subject: Re: more sample formats?  too little place left.
Date: Wed, 12 Jun 2002 11:19:05 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0206121117470.31635-100000@sasami.anime.net>
References: <s5h8z5k1sef.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z5k1sef.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Jun 2002, Takashi Iwai wrote:
> At Mon, 10 Jun 2002 13:46:04 -0700 (PDT),
> Dan Hollis wrote:
> > you mean represent each mask bit with separate ascii character?
> no, it's just a byte array as bitmap to hold more than 32bit (int).
> the meaning is same, but the size will be bigger.

It will be fixed size char array? Or it will be variable?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
