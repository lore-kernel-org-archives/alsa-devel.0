From: <jfm3@ouroboros-complex.org>
Subject: Re: Quick question
Date: Tue, 3 Jun 2003 18:01:07 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <41743.24.225.156.130.1054688467.squirrel@webmail.ouroboros-complex.org>
References: Your
        message
        of
        "03
        Jun
        2003
        13:58:08
        EDT."
        <E19NMCj-0006SU-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19NMCj-0006SU-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> and no, you don't need to modify anything about your stock RH system to
> use JACK. the modifications are only needed if you want low
> latency, and such modifications would be needed to get this with just
> ALSA anyway. a jack client will run just as well as a native ALSA
> (better in some senses) when the jack server is run with equivalent
> parameters for the audio hardware.

Not only that, but there's Planet CCRMA, which allows you to make
automated RPM package updates to your stock RH (like up2date or
red-carpet, but cooler) that give you the low latency kernel, precompiled
ALSA drivers, and enough Jack apps to keep you busy for quite some time.

Jack is so great, many developers on this list have named their children
after it. Do the right thing.

(jfm3)




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
