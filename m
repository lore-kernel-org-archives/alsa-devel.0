From: Miguel Pastor <MiguelPastor@adelphia.net>
Subject: Re: [Alsa-user] Playing Surround Sound with Alsa Drivers
Date: 31 Dec 2002 20:36:59 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1041395822.1771.13.camel@TBird.home.net>
References: <200301010408.h0148ars008665@orion.dwf.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301010408.h0148ars008665@orion.dwf.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Reg Clemens <reg@dwf.com>
Cc: Alsa Users Mail List <Alsa-user@lists.sourceforge.net>, PlanetCCRMA Mail List <PlanetCCRMA@ccrma.stanford.edu>, Alsa Dev Mail List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

The surround volume is ok. I used the alsamixer and gmixer to set the
volume. The surround setting controls the volume of the rear speakers. I
can hear sound coming out of the rear speakers when I play a song with
"aplay" using the rear speakers device (a device called cs46xx-rear that
I created in the .asoundrc file). What I cannot do is use the surround40
device that suppose to send sound to all four speakers. 

On Tue, 2002-12-31 at 20:08, Reg Clemens wrote:
    I only suggest this since you didnt mention alsamixer at all.
    You did check it and the surround is not muted and has an amplitude
    above zero.
    
    
    -- 
                                            Reg.Clemens
                                            reg@dwf.com
    
    
    
    



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
